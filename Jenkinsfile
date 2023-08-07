pipeline {
    agent any

    environment {
        // Define environment variables if needed
        SONAR_HOST_URL = 'http://13.211.153.80:9000'
        DOCKER_REGISTRY_URL = "docker.io"
        DOCKER_CREDENTIALS = credentials('docker-cred')
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull code from GitHub repository using System Default Git installation
                git branch: 'main', url: 'https://github.com/shravandevops/kidtree.git'
            }
        }

        stage('Build') {
            steps {
                // Build the project using Maven
                sh 'mvn clean install'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                // Run SonarQube analysis on the project
                withSonarQubeEnv('SonarQubeServer') {
                    sh "mvn sonar:sonar -Dsonar.host.url=${SONAR_HOST_URL}"
                }
            }
        }

        stage('Build and Push Docker Image') {
            environment {
                // ... previous environment variables ...
                DOCKER_IMAGE = "shravandevops/java-demo:${BUILD_NUMBER}"
                WORKSPACE_DIR = "$WORKSPACE/javatwo"
            }
            steps {
                script {
                    sh 'cp /var/lib/jenkins/.m2/repository/com/shravan/java-demo/1.0/java-demo-1.0.jar $WORKSPACE_DIR'
                    // Build Docker image
                    sh "docker build -t ${DOCKER_IMAGE} ."

                    // Authenticate with Docker registry
                    withDockerRegistry(credentialsId: 'docker-cred', url: "${DOCKER_REGISTRY_URL}") {
                        // Push Docker image to the registry
                        sh "docker push ${DOCKER_IMAGE}"
                    }
                }
            }
        }
    }
}
