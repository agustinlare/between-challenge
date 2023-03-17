filpipeline {
    agent any
    
    stages {
        stage('Checkout SVN') {
            steps {
                script {
                    def svnDir = checkout([$class: 'SubversionSCM',
                    excludedCommitMessages: '', 
                    excludedRegions: '', 
                    excludedRevprop: '', 
                    excludedUsers: '', 
                    filterChangelog: false, 
                    ignoreDirPropChanges: false, 
                    includedRegions: '', 
                    locations: [[
                        credentialsId: 'h3ll0-w0rld-svn-creds', 
                        depthOption: 'infinity', 
                        ignoreExternalsOption: true, 
                        local: 'cable_branch',
                        remote: "https://svn.com/repo/"]]])
                    env.SVN_DIR = svnDir
                }
            }
        }
        
        stage('Clone Git') {
            steps {
                script {
                    dir('tmp') {
                        git branch: 'master',
                            credentialsId: 'ssh-key-credentials',
                            url: 'git@github.com/org/project'

                        sh 'cp -r repo/* $SVN_DIR/git-code'
                    }
                }
            }
        }
        
        stage('Build and Test') {
            steps {
                dir('$SVN_DIR/git-code') {
                    sh 'make install'
                    sh 'make test'
                }
            }
        }
        
        stage('Push to Git') {
            when {
                expression { currentBuild.result == 'SUCCESS' }
            }
            steps {
                dir('$SVN_DIR/git-code') {
                    gitPush(branch: 'master',
                    credentialsId: 'git-credentials-ssh',
                    gitTool: 'default',
                    url: 'git@github.com/org/project')
                }
            }
        }
    }
    
    post {
        always {
            mail to: 'user@between.com',
                subject: "${currentBuild.result}: Build and Test",
                body: "${currentBuild.result}: Build and Test"

            sh 'rm -rf $SVN_DIR'
        }
    }
}