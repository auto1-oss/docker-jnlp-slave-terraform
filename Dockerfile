#
# This file is part of the auto1-oss/docker-jnlp-slave-terraform.
#
# (c) AUTO1 Group SE https://www.auto1-group.com
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

FROM jenkins/jnlp-slave:3.23-1-alpine

ENV TERRAFORM_VERSION=0.11.7

# We'll use jenkins master for deploy, so we need to install dependencies
# Usually jenkins slave should be used for that
USER root
RUN apk --update add wget python py-setuptools py-pip jq docker && \
    pip install awscli && \
    apk del py-pip && \
    wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/tf.zip && \
    unzip -o /tmp/tf.zip -d /usr/bin/ && \
    rm -rf /var/cache/apk/* /tmp/tf.zip
