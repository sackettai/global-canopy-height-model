#!/bin/bash


# DEPLOY_IMAGE_PATH="./deploy_example/sentinel2/2020/S2A_MSIL2A_20200623T103031_N0214_R108_T32TMT_20200623T142851.zip"

# kingston
# BASE_PATH = "./kingston"
# DEPLOY_IMAGE_PATH="$BASE_PATH/images/S2B_MSIL2A_20241105T002049_N0511_R116_T55HCT_20241105T020739.SAFE.zip"

# bass coast
BASE_PATH="./bass_coast"
DEPLOY_IMAGE_PATH="$BASE_PATH/images/S2B_MSIL2A_20241003T001109_N0511_R073_T55HCT_20241003T032207.SAFE.zip"

# wonthaggi
BASE_PATH="./wonthaggi"
DEPLOY_IMAGE_PATH="$BASE_PATH/sentinel-2/S2B_MSIL2A_20190831T001109_N0500_R073_T55HCT_20230524T101240.SAFE.zip"

GCHM_DEPLOY_DIR="$BASE_PATH/predictions"

GCHM_MODEL_DIR="./trained_models/GLOBAL_GEDI_2019_2020"
GCHM_NUM_MODELS="5"

filepath_failed_image_paths="$BASE_PATH/log_failed.txt"

GCHM_DOWNLOAD_FROM_AWS="False"
GCHM_DEPLOY_SENTINEL2_AWS_DIR="$BASE_PATH/sentinel2_aws"

# create directories
mkdir -p ${GCHM_DEPLOY_DIR}
mkdir -p ${GCHM_DEPLOY_SENTINEL2_AWS_DIR}

python3 gchm/deploy.py --model_dir=${GCHM_MODEL_DIR} \
                       --deploy_image_path=${DEPLOY_IMAGE_PATH} \
                       --deploy_dir=${GCHM_DEPLOY_DIR} \
                       --deploy_patch_size=512 \
                       --num_workers_deploy=0 \
                       --num_models=${GCHM_NUM_MODELS} \
                       --finetune_strategy="FT_Lm_SRCB" \
                       --filepath_failed_image_paths=${filepath_failed_image_paths} \
                       --download_from_aws=${GCHM_DOWNLOAD_FROM_AWS} \
                       --sentinel2_dir=${sentinel2_dir} \
                       --remove_image_after_pred="False"

