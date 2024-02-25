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
                    sh "docker build --no-cache -t pgpedurekaproject1:latest ."
                }
            }
        }
        stage('Push Docker image to Docker Hub') {
            steps {
                script {
                                    sh 'ansible-playbook -i inventory dockerc.yml'

                    }
                }
            }
        }
    }
}

