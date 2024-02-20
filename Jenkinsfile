pipeline {
    agent {
        label 'Agent1'
    }

    //environment {
      //  DOCKER_HUB_USERNAME = credentials('hellowordl977')
       // DOCKER_HUB_PASSWORD = credentials('Pass12345')
       // DOCKER_IMAGE_NAME = 'pgpedurekaproject1'
       // DOCKER_IMAGE_TAG = 'V1' // or any other tag you want to use
   // }

    stages {
        stage('Checkout') {
            environment {
                // Define the branch name
                BRANCH_NAME = 'main'
            }

            steps {
                // Checkout source code from version control
                checkout([$class: 'GitSCM',
                    branches: [[name: "${BRANCH_NAME}"]],
                    userRemoteConfigs: [[url: 'https://github.com/kmmehtamca/pgpedurekaproject.git']]])
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
                sh '/opt/maven/bin/mvn package'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Assuming your Dockerfile is located at the root of your project directory
                    // Define the directory path you want to change to
                    sh 'docker build --no-cache -t pgpedurekaproject1:V1 .'
                }
            }
        }
        //stage('Push Docker image to Docker Hub') {
          //  steps {
            //    script {
                    // Authenticate with Docker Hub

		withCredentials([usernamePassword(credentialsId: 'Dockerhub_password', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
		// Login to Docker registry
                        sh "docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}"
                        
                        // Build and push Docker image
                       // sh "docker build -t ${env.DOCKER_REGISTRY}/your-image-name ."
                        //sh "docker push ${env.DOCKER_REGISTRY}/your-image-name"

		       // Logout from Docker registry
                        sh "docker logout"

              //      docker.withRegistry('https://index.docker.io/v1/', "${env.DOCKER_HUB_USERNAME}", "${env.DOCKER_HUB_PASSWORD}") {
                        // Push the Docker image to Docker Hub
                        //docker.image("${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG}").push()
                    }
                }
            }
        }
    }
}

