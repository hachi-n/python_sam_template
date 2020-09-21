#!/bin/bash  

PROJECT_DIR=$(cd $(dirname $0); echo $(dirname `pwd`))
DISTINATION_DIR="${PROJECT_DIR}/layers/dist"
DISTINATION_THIRD_PARTY_DIR="${DISTINATION_DIR}/python"

rm -rf ${DISTINATION_DIR}
mkdir -p ${DISTINATION_THIRD_PARTY_DIR}

pipenv lock -r > "${PROJECT_DIR}/functions/requirements.txt"
pip install -r "${PROJECT_DIR}/functions/requirements.txt" -t "${DISTINATION_THIRD_PARTY_DIR}"

cd ${DISTINATION_DIR}

zip -r "python.zip" "python"

echo "library packaging finish!!"  
