# module Fastlane
	# module Actions

		 #class RWBuildFrameworkAction #< Action
			#def self.run(params)
				#build_target = params[:project]
				build_target = "RWProgressDemo"
				current_path = Dir.pwd
				framework = "#{current_path}/#{build_target}.framework"
				if File.exist?(framework)
					FileUtils.rm_rf(framework)
				end

				build_path = "#{current_path}/build"
				build_project = "#{current_path}/Example/Pods/Pods.xcodeproj"

				build_config = "Release"

				# 使用archive构建真机framework，使用build构建模拟器framework
				archive_command = "xcodebuild clean archive -project #{build_project} -scheme #{build_target} -configuration #{build_config} -sdk iphoneos OBJROOT=#{build_path} SYMROOT=#{build_path} ONLY_ACTIVE_ARCH=NO | xcpretty"
				build_command = "xcodebuild clean build -project #{build_project} -scheme #{build_target} -configuration #{build_config} -sdk iphonesimulator OBJROOT=#{build_path} SYMROOT=#{build_path} ONLY_ACTIVE_ARCH=NO | xcpretty"

				#Actions.sh(archive_command)
				#Actions.sh(build_command)

        		# 将framework复制到项目根目录
       			iphone_framework="#{build_path}/UninstalledProducts/iphoneos/#{build_target}.framework"
       			simulator_framework="#{build_path}/#{build_config}-iphonesimulator/#{build_target}/#{build_target}.framework"
       			target_framework="#{current_path}/#{build_target}.framework"

       			# 合并真机和模拟器二进制文件
        		lipo_command = "lipo -create -output #{target_framework}/#{build_target} #{simulator_framework}/#{build_target} #{iphone_framework}/#{build_target}"
        		#Actions.sh(lipo_command)

        		# 清理build文件
        		#Actions.sh "rm -rf #{build_path}"

        		# 打开项目根目录
        		#Actions.sh "open #{current_path}"

				puts build_target
				puts current_path
				puts framework
				puts build_path
				puts build_project

			#end
		 #end
	# end
# end
