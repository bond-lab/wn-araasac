###
### Make a new release of the araasac wordnets
###

LANGUAGES="an ar bg br ca cs da de el en es et eu fa fr gl he hr hu it ko lt lv mk nb nl pl pt ro ru sk sq sv sr val uk zh"
export LANGUAGES

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

TMPDIR="etc/"
VERSION='2025.03.01'
CILIDIR="${TMPDIR}/cili"
BLDDIR="build/ara-wn-${VERSION}"
export VERSION
export BLDDIR

mkdir -p ${BLDDIR}/json
mkdir -p ${BLDDIR}/tab

#bash scripts/download.sh
python scripts/ara2tab.py ${BLDDIR}/json ${BLDDIR}/tab "$LANGUAGES"

bash scripts/build.sh

#bash scripts/package.sh
