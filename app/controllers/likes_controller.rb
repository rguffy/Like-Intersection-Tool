# To change this template, choose Tools | Templates
# and open the template in the editor.

class LikesController < ApplicationController
    def initialize

    end

    def index

    end

    def show
        @access_token = @facebook_cookies['access_token']
        @graph = Koala::Facebook::API.new(@access_token)

        # @todo possibly store @graph in session
        session[:graph_id] = @graph

        @friends = @graph.get_connections("me", "friends")
        @friends.sort! {|a,b| a['name'] <=> b['name']}
    end
end
