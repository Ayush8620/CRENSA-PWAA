CREATE TABLE "audit_logs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"admin_id" uuid NOT NULL,
	"action" varchar(100) NOT NULL,
	"target_type" varchar(50) NOT NULL,
	"target_id" uuid NOT NULL,
	"details" jsonb,
	"ip_address" varchar(45),
	"user_agent" text,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "categories" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar(100) NOT NULL,
	"slug" varchar(100) NOT NULL,
	"description" text,
	"icon_url" text,
	"video_count" integer DEFAULT 0 NOT NULL,
	"series_count" integer DEFAULT 0 NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "categories_name_unique" UNIQUE("name"),
	CONSTRAINT "categories_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "coin_packages" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" varchar(100) NOT NULL,
	"coin_amount" integer NOT NULL,
	"rupee_price" numeric(10, 2) NOT NULL,
	"bonus_coins" integer DEFAULT 0 NOT NULL,
	"is_popular" boolean DEFAULT false NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"display_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "coin_transactions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"transaction_type" varchar(50) NOT NULL,
	"coin_amount" integer NOT NULL,
	"rupee_amount" numeric(10, 2),
	"related_content_type" varchar(50),
	"related_content_id" uuid,
	"payment_id" varchar(255),
	"status" varchar(50) DEFAULT 'completed' NOT NULL,
	"description" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "content_filters" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"type" varchar(50) NOT NULL,
	"pattern" text NOT NULL,
	"severity" varchar(20) NOT NULL,
	"action" varchar(50) NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_by" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "creator_follows" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"follower_id" uuid NOT NULL,
	"creator_id" uuid NOT NULL,
	"followed_at" timestamp DEFAULT now() NOT NULL,
	"notification_enabled" boolean DEFAULT true NOT NULL,
	"source" varchar(50) DEFAULT 'dashboard' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "creator_profiles" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"display_name" varchar(255) NOT NULL,
	"bio" text,
	"total_earnings" numeric(10, 2) DEFAULT '0.00' NOT NULL,
	"total_views" integer DEFAULT 0 NOT NULL,
	"video_count" integer DEFAULT 0 NOT NULL,
	"series_count" integer DEFAULT 0 NOT NULL,
	"social_links" jsonb,
	"coin_balance" integer DEFAULT 0 NOT NULL,
	"total_coins_earned" integer DEFAULT 0 NOT NULL,
	"coins_withdrawn" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "member_activities" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"activity_type" varchar(50) NOT NULL,
	"title" varchar(255) NOT NULL,
	"description" text,
	"metadata" jsonb,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "member_profiles" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"wallet_balance" numeric(10, 2) DEFAULT '0.00' NOT NULL,
	"membership_status" varchar(20) DEFAULT 'free' NOT NULL,
	"membership_expiry" timestamp,
	"auto_renew" boolean DEFAULT false NOT NULL,
	"watch_history" jsonb DEFAULT '[]'::jsonb,
	"favorite_creators" jsonb DEFAULT '[]'::jsonb,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "member_stats" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"total_videos_watched" integer DEFAULT 0 NOT NULL,
	"total_credits_spent" numeric(10, 2) DEFAULT '0.00' NOT NULL,
	"followed_creators_count" integer DEFAULT 0 NOT NULL,
	"favorite_category" varchar(100),
	"monthly_videos_watched" integer DEFAULT 0 NOT NULL,
	"monthly_credits_spent" numeric(10, 2) DEFAULT '0.00' NOT NULL,
	"monthly_new_follows" integer DEFAULT 0 NOT NULL,
	"last_updated" timestamp DEFAULT now() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "member_stats_user_id_unique" UNIQUE("user_id")
);
--> statement-breakpoint
CREATE TABLE "notifications" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"type" varchar(50) NOT NULL,
	"title" varchar(255) NOT NULL,
	"message" text NOT NULL,
	"is_read" boolean DEFAULT false NOT NULL,
	"metadata" jsonb,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "profile_visits" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"creator_id" uuid NOT NULL,
	"visited_at" timestamp DEFAULT now() NOT NULL,
	"source" varchar(50) NOT NULL,
	"duration" integer,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "promotional_offers" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" varchar(255) NOT NULL,
	"description" text NOT NULL,
	"type" varchar(50) NOT NULL,
	"value" varchar(100) NOT NULL,
	"original_price" numeric(10, 2),
	"discounted_price" numeric(10, 2),
	"valid_from" timestamp DEFAULT now() NOT NULL,
	"valid_until" timestamp NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"is_limited" boolean DEFAULT false NOT NULL,
	"total_count" integer,
	"used_count" integer DEFAULT 0 NOT NULL,
	"cta_text" varchar(100) NOT NULL,
	"cta_link" varchar(255) NOT NULL,
	"target_audience" varchar(50) DEFAULT 'all',
	"metadata" jsonb,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "reports" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"reporter_id" uuid NOT NULL,
	"reported_user_id" uuid,
	"reported_video_id" uuid,
	"type" varchar(50) NOT NULL,
	"reason" varchar(100) NOT NULL,
	"description" text,
	"status" varchar(20) DEFAULT 'pending' NOT NULL,
	"reviewed_by" uuid,
	"reviewed_at" timestamp,
	"resolution" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "series" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"creator_id" uuid NOT NULL,
	"title" varchar(255) NOT NULL,
	"description" text,
	"thumbnail_url" text,
	"total_price" numeric(10, 2) NOT NULL,
	"coin_price" integer NOT NULL,
	"video_count" integer DEFAULT 0 NOT NULL,
	"total_duration" integer DEFAULT 0 NOT NULL,
	"category" varchar(100) NOT NULL,
	"tags" jsonb DEFAULT '[]'::jsonb,
	"view_count" integer DEFAULT 0 NOT NULL,
	"total_earnings" numeric(10, 2) DEFAULT '0.00' NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"moderation_status" varchar(20) DEFAULT 'approved' NOT NULL,
	"moderation_reason" text,
	"moderated_at" timestamp,
	"moderated_by" uuid,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "series_progress" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"series_id" uuid NOT NULL,
	"user_id" uuid NOT NULL,
	"current_video_id" uuid,
	"videos_watched" integer DEFAULT 0 NOT NULL,
	"total_videos" integer DEFAULT 0 NOT NULL,
	"progress_percentage" numeric(5, 2) DEFAULT '0.00' NOT NULL,
	"last_watched_at" timestamp DEFAULT now() NOT NULL,
	"completed_at" timestamp,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "series_purchases" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"series_id" uuid NOT NULL,
	"user_id" uuid NOT NULL,
	"purchase_price" numeric(10, 2) NOT NULL,
	"razorpay_payment_id" varchar(255),
	"razorpay_order_id" varchar(255),
	"status" varchar(20) DEFAULT 'pending' NOT NULL,
	"purchased_at" timestamp DEFAULT now() NOT NULL,
	"expires_at" timestamp,
	"metadata" jsonb,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "series_videos" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"series_id" uuid NOT NULL,
	"video_id" uuid NOT NULL,
	"order_index" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "transactions" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"type" varchar(50) NOT NULL,
	"amount" numeric(10, 2) NOT NULL,
	"video_id" uuid,
	"series_id" uuid,
	"creator_id" uuid,
	"razorpay_payment_id" varchar(255),
	"razorpay_order_id" varchar(255),
	"status" varchar(20) DEFAULT 'pending' NOT NULL,
	"metadata" jsonb,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user_preferences" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"notifications" jsonb DEFAULT '{"email":true,"push":true,"earnings":true,"newFollowers":true,"videoComments":true}'::jsonb,
	"privacy" jsonb DEFAULT '{"profileVisibility":"public","showEarnings":true,"showViewCount":true}'::jsonb,
	"playback" jsonb DEFAULT '{"autoplay":true,"quality":"auto","volume":80}'::jsonb,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "user_preferences_user_id_unique" UNIQUE("user_id")
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"clerk_id" varchar(255) NOT NULL,
	"email" varchar(255) NOT NULL,
	"username" varchar(100) NOT NULL,
	"role" varchar(20) NOT NULL,
	"avatar" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"is_suspended" boolean DEFAULT false NOT NULL,
	"suspension_reason" text,
	"suspended_at" timestamp,
	"suspended_by" uuid,
	"coin_balance" integer DEFAULT 0 NOT NULL,
	"total_coins_purchased" integer DEFAULT 0 NOT NULL,
	"total_coins_spent" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "users_clerk_id_unique" UNIQUE("clerk_id"),
	CONSTRAINT "users_email_unique" UNIQUE("email"),
	CONSTRAINT "users_username_unique" UNIQUE("username")
);
--> statement-breakpoint
CREATE TABLE "video_comments" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"video_id" uuid NOT NULL,
	"content" text NOT NULL,
	"parent_id" uuid,
	"is_edited" boolean DEFAULT false NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "video_likes" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"video_id" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "video_saves" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" uuid NOT NULL,
	"video_id" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "video_shares" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"video_id" uuid NOT NULL,
	"creator_id" uuid NOT NULL,
	"share_token" varchar(255) NOT NULL,
	"platform" varchar(50),
	"click_count" integer DEFAULT 0 NOT NULL,
	"view_count" integer DEFAULT 0 NOT NULL,
	"conversion_count" integer DEFAULT 0 NOT NULL,
	"last_accessed_at" timestamp,
	"is_active" boolean DEFAULT true NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "video_shares_share_token_unique" UNIQUE("share_token")
);
--> statement-breakpoint
CREATE TABLE "videos" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"creator_id" uuid NOT NULL,
	"title" varchar(255) NOT NULL,
	"description" text,
	"video_url" text NOT NULL,
	"thumbnail_url" text NOT NULL,
	"duration" integer NOT NULL,
	"credit_cost" numeric(5, 2) NOT NULL,
	"coin_price" integer NOT NULL,
	"category" varchar(100) NOT NULL,
	"tags" jsonb DEFAULT '[]'::jsonb,
	"view_count" integer DEFAULT 0 NOT NULL,
	"total_earnings" numeric(10, 2) DEFAULT '0.00' NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"moderation_status" varchar(20) DEFAULT 'approved' NOT NULL,
	"moderation_reason" text,
	"moderated_at" timestamp,
	"moderated_by" uuid,
	"aspect_ratio" varchar(10) DEFAULT '16:9' NOT NULL,
	"series_id" uuid,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_admin_id_users_id_fk" FOREIGN KEY ("admin_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "coin_transactions" ADD CONSTRAINT "coin_transactions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "content_filters" ADD CONSTRAINT "content_filters_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "creator_follows" ADD CONSTRAINT "creator_follows_follower_id_users_id_fk" FOREIGN KEY ("follower_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "creator_follows" ADD CONSTRAINT "creator_follows_creator_id_users_id_fk" FOREIGN KEY ("creator_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "creator_profiles" ADD CONSTRAINT "creator_profiles_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "member_activities" ADD CONSTRAINT "member_activities_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "member_profiles" ADD CONSTRAINT "member_profiles_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "member_stats" ADD CONSTRAINT "member_stats_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "profile_visits" ADD CONSTRAINT "profile_visits_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "profile_visits" ADD CONSTRAINT "profile_visits_creator_id_users_id_fk" FOREIGN KEY ("creator_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "reports" ADD CONSTRAINT "reports_reporter_id_users_id_fk" FOREIGN KEY ("reporter_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "reports" ADD CONSTRAINT "reports_reported_user_id_users_id_fk" FOREIGN KEY ("reported_user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "reports" ADD CONSTRAINT "reports_reported_video_id_videos_id_fk" FOREIGN KEY ("reported_video_id") REFERENCES "public"."videos"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "reports" ADD CONSTRAINT "reports_reviewed_by_users_id_fk" FOREIGN KEY ("reviewed_by") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "series" ADD CONSTRAINT "series_creator_id_users_id_fk" FOREIGN KEY ("creator_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "series" ADD CONSTRAINT "series_moderated_by_users_id_fk" FOREIGN KEY ("moderated_by") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "series_progress" ADD CONSTRAINT "series_progress_series_id_series_id_fk" FOREIGN KEY ("series_id") REFERENCES "public"."series"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "series_progress" ADD CONSTRAINT "series_progress_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "series_progress" ADD CONSTRAINT "series_progress_current_video_id_videos_id_fk" FOREIGN KEY ("current_video_id") REFERENCES "public"."videos"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "series_purchases" ADD CONSTRAINT "series_purchases_series_id_series_id_fk" FOREIGN KEY ("series_id") REFERENCES "public"."series"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "series_purchases" ADD CONSTRAINT "series_purchases_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "series_videos" ADD CONSTRAINT "series_videos_series_id_series_id_fk" FOREIGN KEY ("series_id") REFERENCES "public"."series"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "series_videos" ADD CONSTRAINT "series_videos_video_id_videos_id_fk" FOREIGN KEY ("video_id") REFERENCES "public"."videos"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_video_id_videos_id_fk" FOREIGN KEY ("video_id") REFERENCES "public"."videos"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_series_id_series_id_fk" FOREIGN KEY ("series_id") REFERENCES "public"."series"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_creator_id_users_id_fk" FOREIGN KEY ("creator_id") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_preferences" ADD CONSTRAINT "user_preferences_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "video_comments" ADD CONSTRAINT "video_comments_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "video_comments" ADD CONSTRAINT "video_comments_video_id_videos_id_fk" FOREIGN KEY ("video_id") REFERENCES "public"."videos"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "video_likes" ADD CONSTRAINT "video_likes_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "video_likes" ADD CONSTRAINT "video_likes_video_id_videos_id_fk" FOREIGN KEY ("video_id") REFERENCES "public"."videos"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "video_saves" ADD CONSTRAINT "video_saves_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "video_saves" ADD CONSTRAINT "video_saves_video_id_videos_id_fk" FOREIGN KEY ("video_id") REFERENCES "public"."videos"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "video_shares" ADD CONSTRAINT "video_shares_video_id_videos_id_fk" FOREIGN KEY ("video_id") REFERENCES "public"."videos"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "video_shares" ADD CONSTRAINT "video_shares_creator_id_users_id_fk" FOREIGN KEY ("creator_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "videos" ADD CONSTRAINT "videos_creator_id_users_id_fk" FOREIGN KEY ("creator_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "videos" ADD CONSTRAINT "videos_moderated_by_users_id_fk" FOREIGN KEY ("moderated_by") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "videos" ADD CONSTRAINT "videos_series_id_series_id_fk" FOREIGN KEY ("series_id") REFERENCES "public"."series"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "audit_logs_admin_id_idx" ON "audit_logs" USING btree ("admin_id");--> statement-breakpoint
CREATE INDEX "audit_logs_action_idx" ON "audit_logs" USING btree ("action");--> statement-breakpoint
CREATE INDEX "audit_logs_target_type_idx" ON "audit_logs" USING btree ("target_type");--> statement-breakpoint
CREATE INDEX "audit_logs_created_at_idx" ON "audit_logs" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "categories_name_idx" ON "categories" USING btree ("name");--> statement-breakpoint
CREATE INDEX "categories_slug_idx" ON "categories" USING btree ("slug");--> statement-breakpoint
CREATE INDEX "categories_is_active_idx" ON "categories" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "categories_display_order_idx" ON "categories" USING btree ("display_order");--> statement-breakpoint
CREATE INDEX "coin_packages_is_active_idx" ON "coin_packages" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "coin_packages_display_order_idx" ON "coin_packages" USING btree ("display_order");--> statement-breakpoint
CREATE INDEX "coin_transactions_user_id_idx" ON "coin_transactions" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "coin_transactions_type_idx" ON "coin_transactions" USING btree ("transaction_type");--> statement-breakpoint
CREATE INDEX "coin_transactions_created_idx" ON "coin_transactions" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "coin_transactions_status_idx" ON "coin_transactions" USING btree ("status");--> statement-breakpoint
CREATE INDEX "coin_transactions_payment_id_idx" ON "coin_transactions" USING btree ("payment_id");--> statement-breakpoint
CREATE INDEX "content_filters_type_idx" ON "content_filters" USING btree ("type");--> statement-breakpoint
CREATE INDEX "content_filters_severity_idx" ON "content_filters" USING btree ("severity");--> statement-breakpoint
CREATE INDEX "content_filters_is_active_idx" ON "content_filters" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "content_filters_created_by_idx" ON "content_filters" USING btree ("created_by");--> statement-breakpoint
CREATE INDEX "creator_follows_follower_id_idx" ON "creator_follows" USING btree ("follower_id");--> statement-breakpoint
CREATE INDEX "creator_follows_creator_id_idx" ON "creator_follows" USING btree ("creator_id");--> statement-breakpoint
CREATE INDEX "creator_follows_follower_creator_unique" ON "creator_follows" USING btree ("follower_id","creator_id");--> statement-breakpoint
CREATE INDEX "creator_follows_followed_at_idx" ON "creator_follows" USING btree ("followed_at");--> statement-breakpoint
CREATE INDEX "creator_follows_source_idx" ON "creator_follows" USING btree ("source");--> statement-breakpoint
CREATE INDEX "creator_profiles_user_id_idx" ON "creator_profiles" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "creator_profiles_coin_balance_idx" ON "creator_profiles" USING btree ("coin_balance");--> statement-breakpoint
CREATE INDEX "member_activities_user_id_idx" ON "member_activities" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "member_activities_activity_type_idx" ON "member_activities" USING btree ("activity_type");--> statement-breakpoint
CREATE INDEX "member_activities_created_at_idx" ON "member_activities" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "member_profiles_user_id_idx" ON "member_profiles" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "member_stats_user_id_idx" ON "member_stats" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "member_stats_last_updated_idx" ON "member_stats" USING btree ("last_updated");--> statement-breakpoint
CREATE INDEX "notifications_user_id_idx" ON "notifications" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "notifications_type_idx" ON "notifications" USING btree ("type");--> statement-breakpoint
CREATE INDEX "notifications_is_read_idx" ON "notifications" USING btree ("is_read");--> statement-breakpoint
CREATE INDEX "notifications_created_at_idx" ON "notifications" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "profile_visits_user_id_idx" ON "profile_visits" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "profile_visits_creator_id_idx" ON "profile_visits" USING btree ("creator_id");--> statement-breakpoint
CREATE INDEX "profile_visits_visited_at_idx" ON "profile_visits" USING btree ("visited_at");--> statement-breakpoint
CREATE INDEX "profile_visits_source_idx" ON "profile_visits" USING btree ("source");--> statement-breakpoint
CREATE INDEX "promotional_offers_type_idx" ON "promotional_offers" USING btree ("type");--> statement-breakpoint
CREATE INDEX "promotional_offers_is_active_idx" ON "promotional_offers" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "promotional_offers_valid_until_idx" ON "promotional_offers" USING btree ("valid_until");--> statement-breakpoint
CREATE INDEX "promotional_offers_target_audience_idx" ON "promotional_offers" USING btree ("target_audience");--> statement-breakpoint
CREATE INDEX "reports_reporter_id_idx" ON "reports" USING btree ("reporter_id");--> statement-breakpoint
CREATE INDEX "reports_reported_user_id_idx" ON "reports" USING btree ("reported_user_id");--> statement-breakpoint
CREATE INDEX "reports_reported_video_id_idx" ON "reports" USING btree ("reported_video_id");--> statement-breakpoint
CREATE INDEX "reports_status_idx" ON "reports" USING btree ("status");--> statement-breakpoint
CREATE INDEX "reports_type_idx" ON "reports" USING btree ("type");--> statement-breakpoint
CREATE INDEX "reports_created_at_idx" ON "reports" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "series_creator_id_idx" ON "series" USING btree ("creator_id");--> statement-breakpoint
CREATE INDEX "series_category_idx" ON "series" USING btree ("category");--> statement-breakpoint
CREATE INDEX "series_is_active_idx" ON "series" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "series_moderation_status_idx" ON "series" USING btree ("moderation_status");--> statement-breakpoint
CREATE INDEX "series_created_at_idx" ON "series" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "series_view_count_idx" ON "series" USING btree ("view_count");--> statement-breakpoint
CREATE INDEX "series_total_price_idx" ON "series" USING btree ("total_price");--> statement-breakpoint
CREATE INDEX "series_coin_price_idx" ON "series" USING btree ("coin_price");--> statement-breakpoint
CREATE INDEX "series_progress_series_id_idx" ON "series_progress" USING btree ("series_id");--> statement-breakpoint
CREATE INDEX "series_progress_user_id_idx" ON "series_progress" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "series_progress_last_watched_at_idx" ON "series_progress" USING btree ("last_watched_at");--> statement-breakpoint
CREATE INDEX "series_progress_user_series_unique" ON "series_progress" USING btree ("user_id","series_id");--> statement-breakpoint
CREATE INDEX "series_purchases_series_id_idx" ON "series_purchases" USING btree ("series_id");--> statement-breakpoint
CREATE INDEX "series_purchases_user_id_idx" ON "series_purchases" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "series_purchases_status_idx" ON "series_purchases" USING btree ("status");--> statement-breakpoint
CREATE INDEX "series_purchases_purchased_at_idx" ON "series_purchases" USING btree ("purchased_at");--> statement-breakpoint
CREATE INDEX "series_purchases_razorpay_payment_id_idx" ON "series_purchases" USING btree ("razorpay_payment_id");--> statement-breakpoint
CREATE INDEX "series_purchases_user_series_unique" ON "series_purchases" USING btree ("user_id","series_id");--> statement-breakpoint
CREATE INDEX "series_videos_series_id_idx" ON "series_videos" USING btree ("series_id");--> statement-breakpoint
CREATE INDEX "series_videos_video_id_idx" ON "series_videos" USING btree ("video_id");--> statement-breakpoint
CREATE INDEX "series_videos_order_index_idx" ON "series_videos" USING btree ("order_index");--> statement-breakpoint
CREATE INDEX "series_videos_series_video_unique" ON "series_videos" USING btree ("series_id","video_id");--> statement-breakpoint
CREATE INDEX "series_videos_series_order_unique" ON "series_videos" USING btree ("series_id","order_index");--> statement-breakpoint
CREATE INDEX "transactions_user_id_idx" ON "transactions" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "transactions_type_idx" ON "transactions" USING btree ("type");--> statement-breakpoint
CREATE INDEX "transactions_status_idx" ON "transactions" USING btree ("status");--> statement-breakpoint
CREATE INDEX "transactions_created_at_idx" ON "transactions" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "transactions_razorpay_payment_id_idx" ON "transactions" USING btree ("razorpay_payment_id");--> statement-breakpoint
CREATE INDEX "transactions_series_id_idx" ON "transactions" USING btree ("series_id");--> statement-breakpoint
CREATE INDEX "user_preferences_user_id_idx" ON "user_preferences" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "users_clerk_id_idx" ON "users" USING btree ("clerk_id");--> statement-breakpoint
CREATE INDEX "users_email_idx" ON "users" USING btree ("email");--> statement-breakpoint
CREATE INDEX "users_username_idx" ON "users" USING btree ("username");--> statement-breakpoint
CREATE INDEX "users_role_idx" ON "users" USING btree ("role");--> statement-breakpoint
CREATE INDEX "users_is_suspended_idx" ON "users" USING btree ("is_suspended");--> statement-breakpoint
CREATE INDEX "users_coin_balance_idx" ON "users" USING btree ("coin_balance");--> statement-breakpoint
CREATE INDEX "video_comments_user_id_idx" ON "video_comments" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "video_comments_video_id_idx" ON "video_comments" USING btree ("video_id");--> statement-breakpoint
CREATE INDEX "video_comments_parent_id_idx" ON "video_comments" USING btree ("parent_id");--> statement-breakpoint
CREATE INDEX "video_comments_created_at_idx" ON "video_comments" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "video_likes_user_id_idx" ON "video_likes" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "video_likes_video_id_idx" ON "video_likes" USING btree ("video_id");--> statement-breakpoint
CREATE INDEX "video_likes_user_video_unique" ON "video_likes" USING btree ("user_id","video_id");--> statement-breakpoint
CREATE INDEX "video_saves_user_id_idx" ON "video_saves" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "video_saves_video_id_idx" ON "video_saves" USING btree ("video_id");--> statement-breakpoint
CREATE INDEX "video_saves_user_video_unique" ON "video_saves" USING btree ("user_id","video_id");--> statement-breakpoint
CREATE INDEX "video_shares_video_id_idx" ON "video_shares" USING btree ("video_id");--> statement-breakpoint
CREATE INDEX "video_shares_creator_id_idx" ON "video_shares" USING btree ("creator_id");--> statement-breakpoint
CREATE INDEX "video_shares_share_token_idx" ON "video_shares" USING btree ("share_token");--> statement-breakpoint
CREATE INDEX "video_shares_platform_idx" ON "video_shares" USING btree ("platform");--> statement-breakpoint
CREATE INDEX "video_shares_created_at_idx" ON "video_shares" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "videos_creator_id_idx" ON "videos" USING btree ("creator_id");--> statement-breakpoint
CREATE INDEX "videos_category_idx" ON "videos" USING btree ("category");--> statement-breakpoint
CREATE INDEX "videos_is_active_idx" ON "videos" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "videos_moderation_status_idx" ON "videos" USING btree ("moderation_status");--> statement-breakpoint
CREATE INDEX "videos_created_at_idx" ON "videos" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "videos_aspect_ratio_idx" ON "videos" USING btree ("aspect_ratio");--> statement-breakpoint
CREATE INDEX "videos_series_id_idx" ON "videos" USING btree ("series_id");--> statement-breakpoint
CREATE INDEX "videos_coin_price_idx" ON "videos" USING btree ("coin_price");