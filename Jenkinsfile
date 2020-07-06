pipeline {
   agent any
   
   parameters {
       string(defaultValue: '0.0.1', description: '', name: 'RELEASE_VER', trim: false)
       choice(choices: ['DEVELOP', 'RELEASE'], description: '', name: 'RELEASE')
   }

stages {
  stage('Checkout') {
    steps {
      git 'https://github.com/ChabanOS/mdt.git'
    }
  }

  stage('Archie mdt') {
    steps {
      sh label: '', script: """
      cd ${WORKSPACE}
      tar --exclude=\'./README.md\' --exclude=\'./.git\' --exclude=\'./.gitignore\' --exclude=\'./*tar\' -cf mdt-archive-${params.RELEASE}-${params.RELEASE_VER}-${BUILD_NUMBER}.tar ."""
    }
  }

  stage('Create Artifact') {
    steps {
      archiveArtifacts artifacts: '*.tar'
    }
  }

}
  
}
