export AWS_ACCESS_KEY_ID=$INPUT_AWS_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$INPUT_AWS_SECRET_KEY

INPUT_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
INPUT_BUCKET_NAME="elasticbeanstalk-${INPUT_REGION}-${INPUT_ACCOUNT_ID}"

aws s3 cp $INPUT_DEPLOYMENT_PACKAGE s3://${INPUT_BUCKET_NAME}/${INPUT_APPLICATION_NAME}/${INPUT_VERSION_LABEL}.zip && \

aws elasticbeanstalk create-application-version --application-name $INPUT_APPLICATION_NAME --version-label $INPUT_VERSION_LABEL --description "CI/CD" --source-bundle S3Bucket="${INPUT_BUCKET_NAME}",S3Key="${INPUT_APPLICATION_NAME}/${INPUT_VERSION_LABEL}.zip" --region=$INPUT_REGION && \

aws elasticbeanstalk update-environment --environment-name $INPUT_ENVIRONMENT_NAME --version-label $INPUT_VERSION_LABEL --region=$INPUT_REGION


