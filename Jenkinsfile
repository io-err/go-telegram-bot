pipeline {
    agent any

   parameters {
       choice(name: 'TARGETOS', choices: ['linux', 'windows'], description: 'Select the target OS')
       choice(name: 'TARGETARCH', choices: ['amd64', 'arm64'], description: 'Select the target arch')

   }

    stages {
        stage('test') {
            steps {
                echo 'EXECUTING TESTS'
                sh 'make test'
            }
        }
        stage('image') {
            steps {
                echo 'PREPARING IMAGE'
                sh 'make image TARGETARCH=$TARGETARCH TARGETOS=$TARGETOS'
            }
        }
    }
}
