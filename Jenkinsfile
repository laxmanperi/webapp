pipeline {
    agent any
    
    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven",
        terrafrom "terraform"
    }

    stages {
        stage('Hello') {
            steps {
                git branch: 'main', url: 'https://github.com/laxmanperi/webapp.git'
                sh "ls -l"
                
                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        stage('rds creation using terraform') {
            steps {
              sh '''
              terraform --version
              terraform init
              terraform plan
              terraform destroy --auto-approve
              '''
            }
        }
        
        stage('docker build'){
            steps {
               sh "docker build -t webapp ."
            }
        }
        stage('docker push'){
            steps {
                withCredentials([string(credentialsId: 'Dokcer_new_Creds', variable: 'dokcer_creds')]) {
                  sh ''' docker login -u="laxmanperi" -p="$dokcer_creds"
                  docker tag webapp laxmanperi/webapp
                  docker push laxmanperi/webapp
                  '''
                }
            }
        }
        
        stage('eks'){
            steps {
                withCredentials([kubeconfigFile(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    
                   sh '''cat "$KUBECONFIG" > kubeconfignew && cat -n kubeconfignew && export KUBECONFIG=./kubeconfignew
                   kubectl get nodes
                   ls -l
                   kubectl apply -f deployment.yaml
                   kubectl apply -f ingress.yaml
                   '''
                
               }
            }
        }
    }
}
