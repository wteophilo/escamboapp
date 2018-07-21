class Ad < ActiveRecord::Base
  
  TOTAL_PAGE = 6

  before_save :md_to_html
  
  belongs_to :category, counter_cache: true
  belongs_to :member
  has_many :comments

  monetize :price_cents

  has_attached_file :picture, styles: {large: "800x300#", medium: "320x150>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  validates :title, :description_md, :description_short, :category, :price, :picture, :finish_date, presence: true
  validates :price, numericality:{greater_than: 0}

  scope :descending_order, ->(page) {
    order(created_at: :desc).page(page).per(TOTAL_PAGE)
  }

  scope :search, ->(term,page)  {
    where("lower(title) like ?", "%#{term.downcase}%").page(page).per(TOTAL_PAGE)
  } 

  scope :to_the, ->(member){where(member: member)}
  scope :where_category, ->(id, page) { where(category: id).page(page).per(TOTAL_PAGE) }
  
private
    def md_to_html
      options = {
        filter_html: true,
        link_attributes: {
          rel: "nofollow",
          target: "_blank"
        }
      }

      extensions = {
        space_after_headers: true,
        autolink: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)

      self.description = markdown.render(self.description_md)
    end

end
