pipeline{
    agent {
        node {
            label 'maven'
        }
    }
    environment{
        PATH = "/opt/apache-maven-3.8.8/bin:$PATH"
    }
    stages{
        stage('clean-workspace'){
            steps{
                cleanWs()
            }
        }
        stage('clone-code'){
            steps{
                git branch: 'main', url: 'https://github.com/pradyumna93/projects.git'
            }
        }
        stage("package"){
            steps{
                sh 'mvn clean deploy -Dmaven.test.skip=true'
            }
        }
        stage("test"){
            steps{
                echo "----------- unit test started ----------"
                sh 'mvn surefire-report:report'
                 echo "----------- unit test Complted ----------"
            }
        }
        
    }
}    