pipeline {
    agent {
        label 'Agent1'
    }

    environment {
        BRANCH_NAME = 'main'
        SSH_CREDENTIALS = credentials('ansible')
    }

    stages {
        stage('Print User') {
            steps {
                script {
                    sh 'whoami'
                }
            }
        }
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: "${BRANCH_NAME}"]],
                    userRemoteConfigs: [[url: 'https://github.com/kmmehtamca/pgpedurekaproject.git']]])
            }
        }
        stage('Compile') {
            steps {
                sh 'mvn clean'
                sh 'mvn compile'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Push Docker image to Docker Hub') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'ansible', keyFileVariable: 'SSH_PRIVATE_KEY')]) {
                        sh '''
                            ansible-playbook -u ansible dockerc.yml --private-key=${SSH_PRIVATE_KEY} 
                        '''
                    }
                }
            }
        }
    }
}
