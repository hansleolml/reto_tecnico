pipeline {
    agent any
    environment {
        AZ_DOCKER_KEY_ID     = 'jenkins-user-for-docker-repository'
        REPOSITORY_DOCKER    = 'hansleolml/reto_tecnico'
        REPOSITORY_GIT       = 'https://github.com/hansleolml/reto_tecnico.git'
        AZ_K8S_KEY_ID        = 'jenkins-user-for-k8s-azure'
        AZ_GIT_KEY_ID        = 'jenkins-user-for-git-repository'
    }
    stages {
        stage('Git Clone'){
            steps {
                git credentialsId: AZ_GIT_KEY_ID, url: REPOSITORY_GIT
            }
        }
        stage('Prueba login') {
            steps {
                sh("hostname")
                sh("whoami")
                sh("ls -la")
            }
        }
        stage('Conditional deploy') { 
            steps { 
                dir("helmfile") {
                    script { 
                        def lastModifiedFile = sh(script: 'git diff-tree --no-commit-id --name-only -r HEAD', returnStdout: true).trim() 
                        if (lastModifiedFile == 'values-dev.yaml') { 
                            echo "El archivo modificado es: ${lastModifiedFile}" 
                            sh "helmfile -e dev apply" 
                        } else if (lastModifiedFile == 'values-stage.yaml') { 
                            echo "El archivo modificado no es el esperado: ${lastModifiedFile}" 
                            sh'pwd'
                            sh "helmfile -e stage apply"
                        } else {
                            echo "No se realizara ningun cambio"
                            echo "El archivo modificado no es el esperado: ${lastModifiedFile}"         
                        }
                    }
                } 
            } 
        }
    }
    post { 
        always { 
            cleanWs()
        }
    }
}
