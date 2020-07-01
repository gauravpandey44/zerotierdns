pipeline {
  
    agent {
      label 'contabo_production' 
    }  
  
     environment {
            REPO = sh(script: 'echo "${GIT_URL}" | sed -e "s/https:\\/\\/github.com\\/.*\\///" | sed "s/.git//"',returnStdout: true).trim()
     }
  
    stages {

           stage('Build') {
               steps {

                    sh(""" 
                    mkdir -p /home/${USER}/PRODUCTION/dockers/${REPO}
                    cp -p ${WORKSPACE}/* /home/${USER}/PRODUCTION/dockers/${REPO}/
                    """)

                  }
            }
          stage('TEST') {
               steps {

                    sh(""" 
                    echo "TESTING"
                    """)

                  }
            }
          stage('Deploy') {
            steps {

                  sh("""
                  cd /home/${USER}/PRODUCTION/dockers/${REPO}/
                  docker-compose up -d
                  """)
            }

          }

     }
     post {
       always {
         echo "Sending Email"
         emailext subject: '$DEFAULT_SUBJECT',
                    body:  ''' 
                        $DEFAULT_CONTENT
                      ''',
                    recipientProviders: [
                        [$class: 'RequesterRecipientProvider']
                    ], 
                    replyTo: '$DEFAULT_REPLYTO',
                    to: '$DEFAULT_RECIPIENTS',
                    mimeType: 'text/html'
       }
    
    
  }
}
