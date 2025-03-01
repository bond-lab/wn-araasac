# Auxiliary Files for OMW Data Conversion

This directory is for additional files necessary for converting or
analyzing the Arasaac data. Only files that are not trivial to
retrieve are included in the repository, while the others will be
retrieved when building the lexicons.

* **Included**:
- `languages.txt` the list of language supported by arasaac, along with their IETF language code, name in English and autonym.  The code for the language used by araasac differs from IETF for two languages: `br` (should be `pt-BR`) and `val` (should be `ca-valencia`).

* Retrieved from <https://github.com/globalwordnet/cili/> for mapping synsets to ILIs:
  - `cili/ili-map-pwn30.tab`
  - `cili/ili-map-pwn31.tab`

* Retrieved from <https://github.com/omwn/omw-data/> for converting the files:
   * used in `make-release.sh`
      - `etc/omw-data/validate.sh`
      - `etc/omw-data/package.sh`
      - `etc/omw-data/scripts/summarize-release.py`
      - `etc/omw-data/etc/wn-core-ili.tab`
   * used in `scripts/build-lmf.py`
      - `etc/omw-data/scripts/tsv2lmf.py`
