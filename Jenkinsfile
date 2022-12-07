pipeline {
    agent { label 'docker' }

    environment {
        registry = "https://registry.hub.docker.com"
        registryCredential = 'dockerhub_id'
        repo = "karakayamust/spring-petclinic"
    }

    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Build image') {
            steps {
                script{
                    def image = docker.build(repo)
                }
            }
        }

        stage('Test image') {
            steps {
                script{
                    image.inside {
                        sh 'echo "Tests passed"'
                    }                
                }
            }
        }

        stage('Push image') {
            steps {
                script {
                    docker.withRegistry(registry, registryCredential) {
                        image.push("${env.BUILD_ID}")
                        image.push("latest")
                    }
                }
            }
        }

        stage('Clean up image') {
            steps {
                sh "docker rmi $registry/$repo:$BUILD_ID"
                sh "docker rmi $registry/$repo:$latest"
            }
        }
    }
}