pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS') 
    }
    triggers {
        cron('H */4 * * 1-5')
    }
    parameters {
        choice(name: 'GOALS', choices: ['publish','build','test'], description: 'This is dotnet build life cycle' )
    }
    stages{
        stage('git'){
            steps {
                git  url: 'https://github.com/Akhil-Tejas225/nopCommerce.git', branch: 'develop'
            }
        }
        stage('build with sonar'){
            when {
                beforeAgent true
                beforeOptions true
                expression {
                    params.GOALS == 'publish'
                }
            }
            agent {
                node {
                    label 'dotnet'
                }
            }
            // tools {
            //     dotnetsdk 'DOTNET_HOME'   
            // }
            environment {
                DOTNET_TOOLS_PATH = "${HOME}/.dotnet/tools"
                 SONAR_SCANNER = "${HOME}/.dotnet/tools/dotnet-sonarscanner"
            }
            steps {
                withSonarQubeEnv(credentialsId: 'SONAR_CRED', installationName: 'SONAR_QUBE') {
                  sh '$SONAR_SCANNER begin /k:"Akhil-Tejas225_nopCommerce" /o:"spring-petclinic225"'
                  sh 'dotnet build **/src/NopCommerce.sln --no-incremental'
                  sh 'mkdir published'
                  sh 'dotnet publish -c Release **/src/Presentation/Nop.Web/Nop.Web.csproj -o published'
                  sh '$SONAR_SCANNER end' 


                }
            }
        }  
        
    }
}  


