pipeline  {
    environment {
        registry = "https://registry.hub.docker.com"
        registryCredential = 'dockerhub_id'
        repo = "karakayamust/spring-petclinic"
    }


    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        def app = docker.build(repo)
    }

    stage('Test image') {
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        docker.withRegistry(registry, registryCredential) {
            app.push("${env.BUILD_ID}")
            app.push("latest")
        }
    }

    stage('Clean up image') {
        sh "docker rmi $registry/$repo:$BUILD_ID"
        sh "docker rmi $registry/$repo:$latest"
    }
}

