pipeline {
    agent { 
        node { 
            label 'jenkins_slave'
        }
    }
    environment {
        AZ_DOCKER_KEY_ID     = 'jenkins-user-for-docker-repository'
        REPOSITORY_DOCKER    = 'hansleolml/reto_tecnico'
        REPOSITORY_GIT       = 'https://github.com/hansleolml/CI_CD_FULL.git'
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
                sh("az --version")
                sh("ls -la")
            }
        }
        stage('Docker Build') {
            steps {
                script{
                    customImage = docker.build(REPOSITORY_DOCKER +":${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker') {
            steps {
                script {
                    docker.withRegistry('',AZ_DOCKER_KEY_ID) {
                        def now = new Date()
                        customImage.push('latest')
                        customImage.push(now.format("yyMMddHHmmss", TimeZone.getTimeZone('UTC')))
                        sh "docker rmi -f ${env.REPOSITORY_DOCKER}:${env.BUILD_ID} ${env.REPOSITORY}:latest"
                    }
                }
            }
        }
        stage('deploy k8s') {
            steps {
                withCredentials([azureServicePrincipal(AZ_K8S_KEY_ID)]) {
                    //es la unica forma de hacer login con el sh az login segun documentacion
                    sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                    //se agrega flag --overwrite-existing para reempalzar las credencials por siacaso :V 
                    sh 'az aks get-credentials --resource-group kubernetesGroup --name nameAKSCluster --overwrite-existing'
                    sh 'kubectl get nodes'
                    //no ocurre ningun error si ya esta creado el namespaces
                    sh 'kubectl apply -f kubernetes/kuber_namespace.yaml'
                    sh 'kubectl get ns' 
                    sh 'kubectl apply -n springibm -f kubernetes/kuber_deploy.yaml'
                    sh 'kubectl apply -n springibm -f kubernetes/ingress/nodeport.yaml'
                    sh 'kubectl apply -n springibm -f kubernetes/ingress/nodeport_v2.yaml' 
                    //se tiene que eliminar los pods para que se vean los cambios
                    //se elimina los pods con label app = ibmprueba del n springibm" 
                    sh 'kubectl delete pods --namespace=springibm -l app=ibmprueba'
                    sh 'kubectl -n springibm get pods' 
                    sh 'kubectl -n springibm get svc' 
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
