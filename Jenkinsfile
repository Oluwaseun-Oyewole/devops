pipeline {
    agent any

    triggers {
        pollSCM('*/5 * * * *')
    }

    stages {
        stage('Hello') {
            steps {
                echo 'Hello, World!'
            }
        }
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Oluwaseun-Oyewole/devops'
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
        stage('Goodbye') {
            steps {
                echo 'Goodbye, World!'
            }
        }
    }
}