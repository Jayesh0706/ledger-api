pipeline {
    agent any

tools{
    maven 'maven3.9'
    jdk 'jdk21'
}

stages {
        stage('Build') {
            steps {
                sh 'mvn -B compile'
            }
        }


        stage('test') {
            steps {
                sh 'mvn -B test'
            }
        }
}

    post {
        always {
            junit '**/target/surefire-reports/*.xml'
        }
    }

}