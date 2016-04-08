require 'mechanize'
class LatteController < ApplicationController
    def create
        @latte = LatteAccount.new
        @latte.name = params["latte_account"]["name"]
        @latte.password = params["latte_account"]["password"]
        logger.info "Post password::: #{params['latte_account']['password']}"
        @latte.user_id = params["user_id"]
        respond_to do |format|
            if @latte.save
                format.html { redirect_to latte_info_path, task: 'refresh_latte' }
                format.json { render json: @latte, status: :created, location: @latte }
                format.js
            else
                format.html { redirect_to homework_index_path, notice: 'latte not completed.' }
                format.json { render json: @latte.errors, status: :unprocessable_entity }
                format.js { render file: "/app/views/latte/fail"}
            end
        end
    end

    def destroy
      current_user.latte_account.destroy
      respond_to do |format|
         format.js { render file: "/app/views/latte/destroy"}
      end
    end

    def info
      render "latte/info"
      LoadLatteJob.perform_later(current_user)
    end

end
