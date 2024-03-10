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
                sh '/opt/apache-maven-3.9.6/bin/mvn clean'
                sh '/opt/apache-maven-3.9.6/bin/mvn compile'
            }
        }
        stage('Test') {
            steps {
                sh '/opt/apache-maven-3.9.6/bin/mvn test'
            }
        }
        stage('Package') {
            steps {
                sh '/opt/apache-maven-3.9.6/bin/mvn package'
            }
        }
        stage('Print IP Address') {
            steps {
                script {
                    // Execute shell command to get IP address
                    def ipAddress = sh(script: 'hostname -I | cut -d" " -f1', returnStdout: true).trim()
                    echo "IP Address of the host: ${ipAddress}"
                }
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
