pipeline {
    agent {
        label 'Agent1'
    }

    environment {
        BRANCH_NAME = 'main'
        SSH_CREDENTIALS = credentials('ansible')
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
        stage('Push Docker image to Docker Hub') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'ansible', keyFileVariable: 'SSH_PRIVATE_KEY')]) {
                        sh '''
                            ansible-playbook -u ansible1 dockerc.yml --private-key=${SSH_PRIVATE_KEY} 
                        '''
                    }
                }
            }
        }
        stage('Deploy Pods') {
            steps {
                script {
                    // Apply the Kubernetes manifest file
                    sh 'kubectl apply -f deploymentkap.yml'
                }
            }
        }
    }
}
