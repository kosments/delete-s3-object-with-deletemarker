#!/bin/bash

# バケット名と検索文字列を指定
BUCKET_NAME="your-bucket-name"
SEARCH_STRING="dummy"

# 指定したバケットからオブジェクトのリストを取得
for VERSION_ID in $(aws s3api list-object-versions --bucket $BUCKET_NAME --query "Versions[?contains(Key,'$SEARCH_STRING')].VersionId" --output text)
do
  # オブジェクトキーとバージョンIDを取得
  KEY_NAME=$(aws s3api list-object-versions --bucket $BUCKET_NAME --query "Versions[?VersionId=='$VERSION_ID'].Key" --output text)

  # 検索文字列を含むオブジェクトを削除
  echo "Deleting $KEY_NAME"
  aws s3api delete-object --bucket $BUCKET_NAME --key "$KEY_NAME" --version-id $VERSION_ID
done
