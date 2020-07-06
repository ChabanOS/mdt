properties([parameters([choice(choices: ['RELEASE', 'DEVELOP'], description: '', name: 'RELEASE'), string(defaultValue: '0.0.1', description: '', name: 'RELEASE_VER', trim: false)])])

node {
   stage('Checkout') { 
      git 'https://github.com/ChabanOS/mdt.git'
   }
   stage('Build') {
     sh label: '', script: 
     """cd ${WORKSPACE}
     tar --exclude=\'./README.md\' --exclude=\'./.git\' --exclude=\'./.gitignore\' --exclude=\'./*tar\' -cf mdt-archive-${params.RELEASE}-${params.RELEASE_VER}-${BUILD_NUMBER}.tar ."""
      }
   stage('Results') {
      archiveArtifacts '*.tar'
   }
}