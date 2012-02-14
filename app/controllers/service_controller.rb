# To change this template, choose Tools | Templates
# and open the template in the editor.

class ServiceController < ApplicationController
    def initialize

    end

    def common_connections
        graph       = session[:graph_id]
        friends_con = graph.get_connections(params[:id], params[:type])
        my_con      = graph.get_connections('me', params[:type])

        # find common connections
        common = Array.new()
        my_con.each do |mine|
            friends_con.each do |theirs|
                if mine['id'] == theirs['id']
                    common<<mine
                end
            end
        end


        friend_info = graph.get_object(params[:id])
        friend_info.store('total_likes', friends_con.size)
        my_info     = graph.get_object('me')
        my_info.store('total_likes', my_con.size)

        @payload = Hash['me', my_info, 'friend', friend_info, params[:type], common]

        render :json => @payload
    end
end
