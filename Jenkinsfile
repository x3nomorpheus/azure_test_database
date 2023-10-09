  pipeline {

  environment {
    dockerimagename = "x3nomorpheus/mariadb"
    dockerImage = ""
  }

  agent any

  stages {

      steps {
        git 'https://github.com/x3nomorpheus/azure_test_database.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Deploying Database container to Kubernetes') {
      steps {
         sh 'ssh -i /home/jenkins/.ssh/id_rsa -o "StrictHostKeyChecking no" kio@workstation kubectl --kubeconfig /home/kio/k8s/azurek8s delete deployment mariadb || true'
	 sh 'ssh -i /home/jenkins/.ssh/id_rsa -o "StrictHostKeyChecking no" kio@workstation kubectl --kubeconfig /home/kio/k8s/azurek8s apply -f /home/kio/k8s/kubernetes-apps/mariadb.yaml'
      }
    }

  }
