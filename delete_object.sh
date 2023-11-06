#!/bin/bash

# バケット名と検索文字列を指定
BUCKET_NAME="your-bucket-name"
SEARCH_STRING="dummy"

# 指定したバケットからオブジェクトのリストを取得
aws s3api list-object-versions --bucket $BUCKET_NAME | jq -r '.Versions[] | select(.Key | contains("'$SEARCH_STRING'"))' | while read -r line;
  do
    # オブジェクトキーとバージョンIDを取得
    KEY_NAME=$(echo $line | jq -r .Key)
    VERSION_ID=$(echo $line | jq -r .VersionId)

    # 検索文字列を含むオブジェクトを削除
    echo "Deleting $KEY_NAME"
    aws s3api delete-object --bucket $BUCKET_NAME --key "$KEY_NAME" --version-id $VERSION_ID
  done
