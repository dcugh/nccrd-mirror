﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace NCCRD.Services.DataV2.Database.Models
{
    [Table("ProjectRegion")]
    public class ProjectRegion
    {
        public int ProjectRegionId { get; set; }

        //FK - Project
        [Range(0, int.MaxValue, ErrorMessage = "The Project field is required.")]
        public int ProjectId { get; set; }
        public Project Project { get; set; }
        
        //FK - Region
        [Range(0, int.MaxValue, ErrorMessage = "The Region field is required.")]
        public int RegionId { get; set; }
    }
}
