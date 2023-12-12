pipeline{
    agent {
        node {
            label 'maven'
        }
    }
    stages{
        stage('clean-workspace'){
            steps{
                cleanWs()
            }
        }
        stage("bild"){
            steps{
                sh 'mvn clen install'
            }
        }
        stage("package")
        steps{
            sh 'mvn clean package'
        }
    }
}
