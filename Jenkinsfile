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
        stage('clone-code'){
            steps{
                git branch: 'main', url: https://github.com/pradyumna93/projects.git
            }
        }
        stage("bild"){
            steps{
                sh 'mvn clen install'
            }
        }
    }
}