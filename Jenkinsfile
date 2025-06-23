// pipeline {
//     agent any
//     options {
//         timeout(time: 1, unit: 'HOURS') 
//     }
//     triggers {
//         cron('H */4 * * 1-5')
//     }
//     parameters {
//         choice(name: 'GOALS', choices: ['publish','build','test'], description: 'This is dotnet build life cycle' )
//     }
//     stages{
//         stage('git'){
//             steps {
//                 git  url: 'https://github.com/Akhil-Tejas225/nopCommerce.git', branch: 'develop'
//             }
//         }
//         stage('build with sonar'){
//             when {
//                 beforeAgent true
//                 beforeOptions true
//                 expression {
//                     params.GOALS == 'publish'
//                 }
//             }
//             agent {
//                 node {
//                     label 'dotnet'
//                 }
//             }
//             tools {
//                 dotnetsdk 'DOTNET_HOME'
//                 sonarscannerformsbuild 'sonarscanerformsbuild'
//             }
//             steps {
//                 withSonarQubeEnv(credentialsId: 'SONAR_CRED', installationName: 'SONAR_QUBE') {
                
//                   sh 'dotnet-sonarscanner begin /k:"Akhil-Tejas225_nopCommerce" /o:"spring-petclinic225"'
//                   sh 'dotnet build **/src/NopCommerce.sln --no-incremental'
//                   sh 'mkdir published'
//                   sh 'dotnet publish -c Release **/src/Presentation/Nop.Web/Nop.Web.csproj -o published'
//                   sh 'dotnet-sonarscanner end' 


//                 }
//             }
//         }  
        
//     }
// }  
pipeline {
  agent {
    label 'linux' // or just `any` if you have default Linux agents
  }

  environment {
    SONAR_TOKEN = credentials('SONAR_TOKEN') // store this in Jenkins Credentials
    DOTNET_TOOLS_PATH = "${HOME}/.dotnet/tools"
  }

  stages {
    stage('Install dotnet-sonarscanner') {
      steps {
        sh '''
          dotnet tool install --global dotnet-sonarscanner
          export PATH="$PATH:$DOTNET_TOOLS_PATH"
          dotnet sonarscanner --version
        '''
      }
    }

    stage('Sonar Begin & Build') {
      steps {
        sh '''
          export PATH="$PATH:$DOTNET_TOOLS_PATH"
          dotnet sonarscanner begin \
            /k:"nopCommerce" \
            /o:"your-org-key" \
            /d:sonar.token=$SONAR_TOKEN \
            /d:sonar.host.url="https://sonarcloud.io"

          dotnet build ./nopCommerce.sln --no-incremental
        '''
      }
    }

    stage('Sonar End') {
      steps {
        sh '''
          export PATH="$PATH:$DOTNET_TOOLS_PATH"
          dotnet sonarscanner end /d:sonar.token=$SONAR_TOKEN
        '''
      }
    }
  }
}

