pipeline {
    agent {
        label 'Agent1'
    }

    environment {
        BRANCH_NAME = 'main'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: "${BRANCH_NAME}"]],
                    userRemoteConfigs: [[url: 'https://github.com/kmmehtamca/pgpedurekaproject.git']]])
            }
        }
        stage('Compile') {
            steps {
                sh '/opt/maven/bin/mvn clean'
                sh '/opt/maven/bin/mvn compile'
            }
        }
        stage('Test') {
            steps {
                sh '/opt/maven/bin/mvn test'
            }
        }
        stage('Package') {
            steps {
                sh '/opt/maven/bin/mvn package'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build --no-cache -t pgpedurekaproject1:${BRANCH_NAME} ."
                }
            }
        }
        stage('Push Docker image to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'Dockerhub_password', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}"
                        sh 'docker tag pgpedurekaproject1:${BRANCH_NAME} helloworld1977/helloworld:${BRANCH_NAME}'
                        sh 'docker push helloworld1977/helloworld:${BRANCH_NAME}'
                    
                        sh "docker logout"
                    }
                }
            }
        }
    }
}

