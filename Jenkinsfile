pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS') 
    }
    triggers {
        cron('H */4 * * 1-5')
    }
    parameters {
        choice(name: GOALS, choices: ['publish','build','test'], descrption: 'This is dotnet build life cycle' )
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
            tools {
                dotnetsdk 'DOTNET_HOME'
            }
            steps {
                 sh '''dotnet sonarscanner begin /k:"project-key" /d:sonar.token="701811083fc0264e739307ac7ba6f6c668c16521"'''
                 sh  '''dotnet build "**/src/Presentation/Nop.Web/Nop.Web.dll"'''
                 sh  '''dotnet sonarscanner end /d:sonar.token="701811083fc0264e739307ac7ba6f6c668c16521"'''

            }
        }  
        
    }
}  
