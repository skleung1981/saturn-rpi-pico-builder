pipeline {
    tools {
        dockerTool 'DEFAULT_DOCKER'
    }

    agent any

    environment {
        PROJECT_NAME = 'saturn-rpi-pico-builder'
    }

    stages {
        stage('Build Image - Saturn Rpi Pico Builder') {
            when {
                allOf {
                    buildingTag()
                    expression { fileExists 'Dockerfile' }
                }
            }
            steps {
                script {
                    def imageName = env.PROJECT_NAME
                    def gitTag = env.TAG_NAME
                    def cleanVersion = gitTag.replaceAll(/^v/, '')
                    def registry = "saturn:30088"
                    def fullImageName = "${registry}/${imageName}"
                    def imageTag = "${fullImageName}:${cleanVersion}"
                    def latestTag = "${fullImageName}:latest"
                }

                withCredentials([usernamePassword(credentialsId: 'nexus-cicd-admin',
                                 usernameVariable: 'nexus_user',
                                 passwordVariable: 'nexus_password')]) {
                    sh '''
                        mkdir -p "${WORKSPACE}/.docker-config"
                        export DOCKER_CONFIG="${WORKSPACE}/.docker-config"
                        echo "$nexus_password" | docker login ''' + registry + ''' -u "$nexus_user" --password-stdin

                        docker build \
                            -t ''' + imageTag + ''' \
                            -t ''' + latestTag + ''' \
                            .

                        docker push ''' + imageTag + '''
                        docker push ''' + latestTag + '''

                        rm -rf "${WORKSPACE}/.docker-config"
                        docker rmi ''' + imageTag + ' ' + latestTag + ''' || true
                    '''
                }
            }
        }
    }

}