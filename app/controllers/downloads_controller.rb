class DownloadsController < ApplicationController
  before_action :load_consultant, only: [:download_resume]

  def download_resume
    if user_signed_in? || admin_signed_in?
      if Rails.env.development?
        redirect_to "/#{@consultant.resume_url}"
      else
        redirect_to @consultant.resume_url
      end
    else
      redirect_to new_sales_lead_path
    end
  end

  def download_article_attachment
    @article_attachment = ArticleAttachment.find(params[:id])
    if user_signed_in? || admin_signed_in?
      if Rails.env.development?
        send_file Rails.root.join("public" + @article_attachment.attach.path),
                  :type => @article_attachment.attach_content_type.to_s,
                  :filename => @article_attachment.attach_file_name,
                  :url_based_filename => true
      else
        redirect_to @article_attachment.attach_url
      end
    else
      redirect_to root_path
    end
  end

  def download_comment_attachment
    @comment_attachment = CommentAttachment.find(params[:id])
    if user_signed_in? || admin_signed_in?
      if Rails.env.development?
        send_file Rails.root.join("public" + @comment_attachment.attach.path),
                  :type => @comment_attachment.attach_content_type.to_s,
                  :filename => @comment_attachment.attach_file_name,
                  :url_based_filename => true
      else
        redirect_to @comment_attachment.attach_url
      end
    else
      redirect_to root_path
    end
  end

  def gsc
    @company = Company.find(params[:id])
    if admin_signed_in? || user_signed_in?
      if Rails.env.development?
        send_file Rails.root.join("public/" + @company.gsc.path),
                  :type => @company.gsc_content_type.to_s,
                  :filename => @company.gsc_file_name,
                  :url_based_filename => true
      else
        redirect_to @company.gsc_url
      end
    else
      redirect_to root_path
    end
  end

  def contract_rider
    @company = Company.find(params[:id])
    if admin_signed_in? || user_signed_in?
      if Rails.env.development?
        send_file Rails.root.join("public/" + @company.contract.path),
                  :type => @company.contract_content_type.to_s,
                  :filename => @company.contract_file_name,
                  :url_based_filename => true
      else
        redirect_to @company.contract_url
      end
    else
      redirect_to root_path
    end
  end

  def sow
    @project = Project.find(params[:id])
    if admin_signed_in?
      if Rails.env.development?
        send_file Rails.root.join("public/" + @project.sow.path),
                  :type => @project.sow_content_type.to_s,
                  :filename => @project.sow_file_name,
                  :url_based_filename => true
      else
        redirect_to @project.sow_url
      end
    else
      redirect_to root_path
    end
  end

  private

  def load_consultant
    @consultant = Consultant.find(params[:id])
  end
end
