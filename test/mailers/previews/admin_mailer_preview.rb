class AdminMailerPreviewController < ActionMailer::Preview
	def update_email
		AdminMailer.update_email(Admin.first,Admin.last)
	end

	def send_email
		AdminMailer.send_message(Admin.first.email,Admin.last.email,"Subject Test","Lorem lore..")
		
	end
end