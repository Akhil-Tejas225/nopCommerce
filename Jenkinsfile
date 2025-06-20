pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS') 
    }
    triggers {
        cron('H */4 * * 1-5')
    }
    parameter {
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
                script{
                    def projpath = sh(script:"find . -name Nop.web.csproj",returnStdout: true).trim()
                    dotnet sonarscanner begin /d:sonar.token="701811083fc0264e739307ac7ba6f6c668c16521"
                    dotnet build "${projpath}"
                    dotnet sonarscanner end /d:sonar.token="701811083fc0264e739307ac7ba6f6c668c16521"
                }
            }
        }  
        
    }
}  
