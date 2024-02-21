pipeline {
    agent 
  {
    label 'Agent1'
  }
   
    stages {
        stage('Change Branch') {
            steps {
                // Checkout the repository and switch to the 'main' branch
                script {
                    git branch: 'main', changelog: false, credentialsId: 'your-git-credentials', url: 'https://github.com/asim1988/finalprojectdureka.git'
                }
            }
        }
       
        stage('Build') {
            steps {
                // Compile and package the Maven project
                script {
                    sh '/opt/maven/bin/mvn clean package'
                }
            }
        }
       
        stage('Test') {
            steps {
                // Run tests (optional)
                script {
                    sh '/opt/maven/bin/mvn test'
                }
            }
        }
       
        stage('Archive') {
            steps {
                // Archive the generated artifact (e.g., JAR, WAR)
                archiveArtifacts 'target/*.war' // Adjust the pattern according to your artifact's extension
            }
        }
stage('Build Docker Image') {
            steps {
                script {
                    // Assuming your Dockerfile is located at the root of your project directory
                    //Define the directory path you want to change to
                 
                              sh 'docker build --no-cache -t edv1asim:V1 .'

                }
            }
        }
    }
}

