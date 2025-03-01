#!/bin/bash

### Script to convert the Arasaac WordNet to WN-LMF

set -e  # Exit immediately on any error

# Ensure required variables are set
: "${LANGFILE:?Error: LANGFILE is not set}"
: "${PREDIR:?Error: PREDIR is not set}"
: "${BLDDIR:?Error: BLDDIR is not set}"
: "${VERSION:?Error: VERSION is not set}"
: "${WNBASE:?Error: WNBASE is not set}"


TMPDIR="etc/"
mkdir -p "${TMPDIR}"

CILIDIR="${TMPDIR}/cili"
OMWDATADIR="${TMPDIR}/omw-data"

# Ensure required repositories are available
if [ ! -d "${CILIDIR}" ]; then
    git clone https://github.com/globalwordnet/cili.git "${CILIDIR}"
fi

if [ ! -d "${OMWDATADIR}" ]; then
    git clone https://github.com/omwn/omw-data.git "${OMWDATADIR}"
fi

# Build Directories
mkdir -p "${BLDDIR}"
mkdir -p "${PREDIR}/log"

URL='https://github.com/omwn/arawn'

#Check for xsltproc Command

if ! command -v xsltproc &> /dev/null; then
    echo "Error: xsltproc is not installed. Please install it first."
    exit 1
fi

# Read languages from file safely
while IFS='|' read -r arasaac bp47 en_name native_name; do
    # Skip empty lines
    if [[ -z "$arasaac" ]]; then
        continue
    fi
    echo "Processing language: ${en_name} ($arasaac ${native_name})"
    
    INPUT_FILE="${PREDIR}/tab/${arasaac}-${WNBASE}.tab"
    
    # Check if file exists and has at least 10 lines
    if [ ! -f "$INPUT_FILE" ] || [ $(wc -l < "$INPUT_FILE") -lt 10 ]; then
        echo "Skipping ${en_name} ($arasaac): File '$INPUT_FILE' has fewer than 10 lines."
        continue
    fi

    mkdir -p "${BLDDIR}/${WNBASE}-${arasaac}"
    
    python "${OMWDATADIR}/scripts/tsv2lmf.py" \
        --id "${WNBASE}-${arasaac}" \
        --version "${VERSION}" \
        --label "Arasaac Wordnet for ${en_name} (${native_name})" \
        --language "${bp47}" \
        --email bond@ieee.org \
        --license 'https://creativecommons.org/licenses/by/4.0/' \
        --meta confidenceScore=1.0 \
        --url "${URL}" \
        --ili-map "${CILIDIR}/ili-map-pwn30.tab" \
        --log "${PREDIR}/log/${WNBASE}-${arasaac}.log" \
        "${INPUT_FILE}" \
        "${BLDDIR}/${WNBASE}-${arasaac}/${WNBASE}-${arasaac}-tmp.xml"

    # Fix license and description
    xsltproc scripts/update_license_description.xsl "${BLDDIR}/${WNBASE}-${arasaac}/${WNBASE}-${arasaac}-tmp.xml" \
        > "${BLDDIR}/${WNBASE}-${arasaac}/${WNBASE}-${arasaac}.xml"
    rm "${BLDDIR}/${WNBASE}-${arasaac}/${WNBASE}-${arasaac}-tmp.xml"

done < "$LANGFILE"
