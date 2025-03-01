JSONDIR=build/json

pushd ${JSONDIR}

for l in ${LANGUAGES}; do
    wget https://api.arasaac.org/api/pictograms/all/${l} -O  ${l}.json
    sleep 15
done

popd

## to make them readable
# cat ${l}.json | jq . > ${l}-pretty.json
