pipeline {
    agent 
    {
        label 'Agent1'
        
    //}

    stages {
        stage('Checkout') {
                        environment {
                // Define the branch name
                BRANCH_NAME = 'main'
            }

            steps {
            
                // Checkout source code from version control
                //git 'https://github.com/kmmehtamca/edjava'
                                checkout([$class: 'GitSCM',
                          branches: [[name: "${BRANCH_NAME}"]],
                          userRemoteConfigs: [[url: 'https://github.com/kmmehtamca/edjava.git']]])

            }
        }
        stage('Compile') {
            steps {
                // Compile the Maven project
                sh '/opt/maven/bin/mvn clean'
                sh '/opt/maven/bin/mvn compile'
            }
        }
        stage('Test') {
            steps {
                // Run tests
                sh '/opt/maven/bin/mvn test'
            }
        }
        stage('Package') {
            steps {
                // Package the Maven project (e.g., create a JAR file)
                sh '/opt//maven/bin/mvn package'
            }
        }
        
    }
}
