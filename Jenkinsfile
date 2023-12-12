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
<<<<<<< HEAD
        stage('clone-code'){
            steps{
                git branch: 'main', url: 'https://github.com/pradyumna93/projects.git'
            }
        }
        stage("package"){
=======
        stage("bild"){
>>>>>>> 2365172c6f46dfc02ae9a2ec2de08a1aaeb6642c
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
<<<<<<< HEAD
}    
=======
}
>>>>>>> 2365172c6f46dfc02ae9a2ec2de08a1aaeb6642c
