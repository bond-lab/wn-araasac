###
### Make a new release of the araasac wordnets
###




### setup python
if [ -d ".venv" ]
then
    source .venv/bin/activate
    pip install -r requirements.txt
else
    python3.9 -m venv .venv
    source .venv/bin/activate
    python3 -m pip install --upgrade pip
    pip install -r requirements.txt
fi


LANGFILE="etc/languages.txt"
TMPDIR="etc/"
WNBASE="arawn"
VERSION='2025'
CILIDIR="${TMPDIR}/cili"
PREDIR="prep/${WNBASE}-${VERSION}"
BLDDIR="build/${WNBASE}-${VERSION}"
export WNBASE VERSION PREDIR BLDDIR LANGFILE

mkdir -p ${PREDIR}/json
mkdir -p ${PREDIR}/tab

#bash scripts/download.sh

LANG_CODES=''
while IFS='|' read -r arasaac _; do
    # Skip empty lines
    if [[ -z "$arasaac" ]]; then
        continue
    fi
    LANG_CODES="$LANG_CODES $arasaac"
done < "$LANGFILE"


#python scripts/ara2tab.py ${PREDIR}/json ${PREDIR}/tab ${WNBASE} "$LANG_CODES"

bash scripts/build-lmf.sh

etc/omw-data/validate.sh


BASEURL="https://github.com/omwn/${WNBASE}/releases/download/${TAG}"
export BASEURL

bash etc/omw-data/package.sh $VERSION v$VERSION


python etc/omw-data/scripts/summarize-release.py \
       --core-ili etc/omw-data/etc/wn-core-ili.tab \
       release/${WNBASE}-${VERSION}.tar.xz > docs/${WNBASE}-${VERSION}-summary.md
