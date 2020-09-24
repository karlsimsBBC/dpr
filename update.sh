#!/usr/bin/env bash

set -eu
# must run from dir with all your code folders in

ticket_number="$1"

tag_name="availability-catchup-domain.version"

current_tags_pattern="<${tag_name}>(.*)</${tag_name}>"
next_version="<${tag_name}>$2</${tag_name}>"

component_names=(
  scheduling-rules-processor
  stream-time-processor
  vhw-change-processor
  optimist
  teletubby
  toyah
  walker
  symbolic-time-resolver
  availability-calculator
)


for name in ${component_names[@]}; do
  if [ -d "$name" ]; then
    cd "$name"
    if grep -q ${current_tags_pattern} pom.xml; then

      current_version=$(grep ${current_tags_pattern} pom.xml)

      if [ ${current_version} = ${next_version} ]; then
        echo "Versions are already equal. skipping"
      else

        echo "Updating ${name}/pom.xml"
        git checkout master
        git pull
        git switch -c ${ticket_number}
        sed -i '.bak' 's#\(<availability-catchup-domain.version>\).*\(</availability-catchup-domain.version>\)#\1'$new_version'\2#g' pom.xml
        git add pom.xml
        git commit -m "${ticket_number} version bump availability-catchup-domain"
        git push --set-upsteam origin ${ticket_number}
      fi
    else
      echo "! ${name}: could not upadate pom.xml"
    fi
    cd - > /dev/null
  else
    echo "! missing compoent: $name"
  fi
done