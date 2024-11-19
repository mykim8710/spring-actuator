#!/bin/bash

# 현재 브랜치가 main인지 확인
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "CURRENT_BRANCH >> $CURRENT_BRANCH"
if [[ "$CURRENT_BRANCH" != "main" ]]; then
  echo "[ERROR] This script must be run on the 'main' branch"
  exit 1
fi

# Merge commit 메시지에서 머지된 브랜치 이름 추출
MERGED_BRANCH_NAME=$(git log -1 --pretty=%B | grep "from" | awk '{print $NF}')
echo "MERGED_BRANCH_NAME >> $MERGED_BRANCH_NAME"
if [[ -z "$MERGED_BRANCH_NAME" ]]; then
  echo "[ERROR] Could not detect merged branch name."
  exit 1
fi

# 브랜치명에서 BRANCH_PART 추출 (release/admin-1.0.1 -> admin-1.0.1)
BRANCH_PART=$(echo "$MERGED_BRANCH_NAME" | awk -F'/' '{print $NF}')
echo "BRANCH_PART >> $BRANCH_PART"

# MODULE_NAME 추출 (admin-1.0.1 -> admin)
MODULE_NAME=$(echo "$BRANCH_PART" | awk -F'-' '{print $1}')
echo "MODULE_NAME >> $MODULE_NAME"

# VERSION 추출 (admin-1.0.1 -> 1.0.1)
VERSION=$(echo "$BRANCH_PART" | awk -F'-' '{if (NF >= 2) print $2"."$3"."$4}' | sed 's/\.*$//')
echo "VERSION >> $VERSION"

if [[ -z "$MODULE_NAME" || -z "$VERSION" ]]; then
  echo "[ERROR] Could not detect MODULE_NAME or VERSION from merged branch: $MERGED_BRANCH_NAME"
  exit 1
fi

## Print the module name
#echo "========================================"
#echo "[INFO] Starting build for MODULE_NAME: $1"
#echo "========================================"
#export MODULE_NAME=$1
#
## Move to project root directory
#echo "----------------------------------------"
#echo "[INFO] Moving to project root directory"
#echo "----------------------------------------"
#cd ../
#
## Grant execution permissions to Gradle wrapper
#echo "----------------------------------------"
#echo "[INFO] Granting execution permissions to gradlew"
#echo "----------------------------------------"
#chmod +x gradlew
#
## 현재 브랜치 이름 가져오기
#BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
#echo "----------------------------------------"
#echo "[INFO] Current branch: $BRANCH_NAME"
#echo "----------------------------------------"
#
## 브랜치에서 버전 추출 (admin-1.0.0 -> 1.0.0)
#VERSION=$(echo $BRANCH_NAME | awk -F'-' '{print $NF}')
#echo "----------------------------------------"
#echo "[INFO] Extracted version: $VERSION"
#echo "----------------------------------------"
#
## Gradle 빌드 실행 시 버전 전달
#echo "----------------------------------------"
#echo "[INFO] Running Gradle build for $MODULE_NAME with version suffix $VERSION"
#echo "----------------------------------------"
#./gradlew clean $MODULE_NAME:build -PversionSuffix=$VERSION || { echo "[ERROR] Gradle build failed"; exit 1; }
#
## Navigate to the module directory
#echo "----------------------------------------"
#echo "[INFO] Navigating to the $MODULE_NAME directory"
#echo "----------------------------------------"
#cd $MODULE_NAME || { echo "[ERROR] Failed to navigate to $MODULE_NAME directory"; exit 1; }
#
## Prepare the before-deploy directory
#echo "----------------------------------------"
#echo "[INFO] Creating before-deploy directory"
#echo "----------------------------------------"
#mkdir -p before-deploy
#
## Copy necessary files to before-deploy
#echo "----------------------------------------"
#echo "[INFO] Copying scripts and configuration files to before-deploy"
#echo "----------------------------------------"
#cp scripts/*.sh before-deploy/ || echo "[WARNING] No scripts found to copy"
#cp appspec-stage.yml before-deploy/appspec.yml || echo "[WARNING] No appspec-stage.yml found"
#cp build/libs/*.jar before-deploy/ || { echo "[ERROR] No JAR files found in build/libs"; exit 1; }
#
## Navigate to the before-deploy directory
#echo "----------------------------------------"
#echo "[INFO] Navigating to before-deploy directory"
#echo "----------------------------------------"
#cd before-deploy || { echo "[ERROR] Failed to navigate to before-deploy directory"; exit 1; }
#
## Zip the files
#echo "----------------------------------------"
#echo "[INFO] Zipping files into diiver-$MODULE_NAME-api.zip"
#echo "----------------------------------------"
#zip -r diiver-$MODULE_NAME-api.zip ./* || { echo "[ERROR] Zipping failed"; exit 1; }
#
## Navigate back to the module directory
#echo "----------------------------------------"
#echo "[INFO] Navigating back to module directory"
#echo "----------------------------------------"
#cd ../
#
## Prepare the deploy directory
#echo "----------------------------------------------"
#echo "[INFO] Creating deploy directory"
#echo "----------------------------------------------"
#mkdir -p deploy
#
## Move the zip file to the deploy directory
#echo "----------------------------------------"
#echo "[INFO] Moving diiver-$MODULE_NAME-api.zip to deploy directory"
#echo "----------------------------------------"