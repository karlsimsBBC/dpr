# Dpr
Scripts to create prs for maven dependency updates.


## Running
Run from root directory containing all your repos.
It will then scan through components listed in the script.

## Opening prs
```bash
$ dpr-open <branch-name> <dependency-id> <version-number>
```

e.g.

```bash
$ dpr-open MSPA-1234 availability-catchup-domain 1.0.13
```

## Closing prs (and deleting branches)
```bash
$ dpr-close <branch-name>
```

e.g.

```bash
$ dpr-close MSPA-1234
```