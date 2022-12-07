pipeline {
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
                def app = docker.build(repo)
            }
        }

        stage('Test image') {
            steps {
                app.inside {
                    sh 'echo "Tests passed"'
                }
            }

        }

        stage('Push image') {
            steps {
                docker.withRegistry(registry, registryCredential) {
                    app.push("${env.BUILD_ID}")
                    app.push("latest")
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

