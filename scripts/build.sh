#!/bin/bash

### Script to convert the Arasaac WordNet to WN-LMF

# Configuration ########################################################

# LANGUAGES, BLDDIR and VERSION are environment variables
#
# set by ../make-release.sh
#


TMPDIR="etc/"

mkdir -p "${TMPDIR}"

CILIDIR="${TMPDIR}/cili"
OMWDATADIR="${TMPDIR}/omw-data"


# Ensure CILI mapping are available
if [ ! -d "${CILIDIR}" ]; then
    git clone https://github.com/globalwordnet/cili.git "${CILIDIR}"
fi

# Ensure OMW-DATA scripts are available
if [ ! -d "${OMWDATADIR}" ]; then
    git clone https://github.com/omwn/omw-data.git "${OMWDATADIR}"
fi


# Build ################################################################

mkdir -p "${BLDDIR}"
mkdir -p "${BLDDIR}/log"

URL='https://github.com/bond-lab/wn-araasac'

for lang in ${LANGUAGES}; do
    echo "Processing language: $lang"

    mkdir -p "${BLDDIR}/ara-${lang}"
    
    python ${OMWDATADIR}/scripts/tsv2lmf.py \
        --id ara-${lang} \
        --version ${VERSION} \
        --label "Wordnet Arasaac for ${lang}" \
        --language ${lang} \
        --email bond@ieee.org \
        --license 'https://creativecommons.org/licenses/by/4.0/' \
        --meta confidenceScore=1.0 \
        --url ${URL} \
        --ili-map ${CILIDIR}/ili-map-pwn30.tab \
        --log ${BLDDIR}/log/ara-${lang}.log \
        ${BLDDIR}/tab/${lang}-ara-wn.tab \
        ${BLDDIR}/ara-${lang}/ara-${lang}.xml

    ### fix license and description
    xsltproc scripts/update_license_description.xsl ${BLDDIR}/ara-${lang}/ara-${lang}.xml > ${BLDDIR}/ara-${lang}/ara-${lang}.xml
    ### make and copy metadata
    ### citation.bib
    ### LICENSE
    ### README
done
